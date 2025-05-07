#!/bin/bash

set -e  # Exit on error

# --- Install VS Code with paru ---
if ! command -v code &> /dev/null; then
  echo "🛠 Installing Visual Studio Code using paru..."
  paru -S --noconfirm visual-studio-code-bin
else
  echo "✅ VS Code already installed."
fi

# --- VS Code paths ---
vscode_user_dir="$HOME/.config/Code/User"
extensions_file="$HOME/.vscode/extensions.json"
settings_file="$vscode_user_dir/settings.json"

# --- Create directories ---
mkdir -p "$(dirname "$extensions_file")"
mkdir -p "$vscode_user_dir"

# --- Extensions list ---
extensions=(
  "bracketpaircolordlw.bracket-pair-color-dlw"
  "bradlc.vscode-tailwindcss"
  "christian-kohler.npm-intellisense"
  "christian-kohler.path-intellisense"
  "donjayamanne.githistory"
  "dsznajder.es7-react-js-snippets"
  "esbenp.prettier-vscode"
  "expo.vscode-expo-theme"
  "formulahendry.auto-close-tag"
  "formulahendry.auto-rename-tag"
  "mechatroner.rainbow-csv"
  "mhutchie.git-graph"
  "ms-vscode.vscode-typescript-next"
  "naumovs.color-highlight"
  "nucllear.vscode-extension-auto-import"
  "oderwat.indent-rainbow"
  "quicktype.quicktype"
  "shd101wyy.markdown-preview-enhanced"
  "steoates.autoimport"
  "waderyan.gitblame"
  "whizkydee.material-palenight-theme"
  "wix.vscode-import-cost"
)

# --- Write extensions.json ---
{
  echo '{'
  echo '  "recommendations": ['
  for i in "${!extensions[@]}"; do
    if [[ $i -eq $((${#extensions[@]} - 1)) ]]; then
      echo "    \"${extensions[$i]}\""
    else
      echo "    \"${extensions[$i]}\","
    fi
  done
  echo '  ]'
  echo '}'
} > "$extensions_file"

echo "✅ extensions.json written to $extensions_file"

# --- Install extensions ---
echo "📦 Installing VS Code extensions..."
for ext in "${extensions[@]}"; do
  code --install-extension "$ext" --force
done

# --- Write settings.json ---
cat > "$settings_file" << EOF
{
  "editor.tabSize": 2,
  "editor.formatOnSave": true,
  "editor.fontFamily": "Fira Code, monospace",
  "editor.fontLigatures": true,
  "workbench.colorTheme": "Material Palenight Theme",
  "workbench.iconTheme": "vs-seti",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.autoSave": "onWindowChange",
  "typescript.tsdk": "node_modules/typescript/lib",
  "explorer.confirmDelete": false
}
EOF

echo "✅ settings.json written to $settings_file"
echo "🎉 Full VS Code setup complete!"
