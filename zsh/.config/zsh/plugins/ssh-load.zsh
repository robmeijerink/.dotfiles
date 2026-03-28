# Command to load SSH keys from Bitwarden
# Developed by: Rob Meijerink (@robmeijerink)
ssh-load() {
    # SSH-Agent Check
    [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null

    # Bitwarden Session Check
    if [ -z "$BW_SESSION" ]; then
        export BW_SESSION=$(bw unlock --raw) || return 1
    fi

    # Cleanup Trap
    local ASKPASS_BIN=$(mktemp)
    trap "rm -f $ASKPASS_BIN; unset BW_SSH_PASSPHRASE; trap - EXIT INT TERM" EXIT INT TERM

    echo "🔍 Syncing SSH Vault..."
    # Use BW SSH CLI item UUID
    local ITEM_JSON=$(bw get item "d237e05f-d63f-4e2e-9dbf-b41b0015c15c" 2>/dev/null)

    if [ -z "$ITEM_JSON" ]; then
        echo "❌ Item not found."
        return 1
    fi

    # 4. Data Extraction (Custom Fields)
    export BW_SSH_PASSPHRASE=$(echo "$ITEM_JSON" | jq -r '.login.password // empty')

    local PRIVATE_KEY=$(echo "$ITEM_JSON" | jq -r '.fields[]? | select(.name=="private_key") | .value // empty')

    if [ -z "$PRIVATE_KEY" ]; then
        echo "❌ Private key not found in custom fields. Check the field name."
        return 1
    fi

    # 5. Private Key Injection
    printf "#!/bin/sh\necho \"\$BW_SSH_PASSPHRASE\"\n" > "$ASKPASS_BIN"
    chmod +x "$ASKPASS_BIN"

    DISPLAY=:0 SSH_ASKPASS_REQUIRE=force SSH_ASKPASS="$ASKPASS_BIN" \
    ssh-add -t 3600 - <<< "$PRIVATE_KEY" < /dev/null

    echo "✅ SSH environment ready (1h timeout)."
}