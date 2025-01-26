# workspaces=$(i3-msg -t get_tree | jq '[recurse(.nodes[]?, .floating_nodes[]?) | select(.type == "workspace") | {workspace: .name, windows: [.nodes[]?, .floating_nodes[]? | recurse(.nodes[]?, .floating_nodes[]?) | select(.window_properties != null) | .window_properties.class]}]')
workspaces=$(i3-msg -t get_tree | jq -r '
    [recurse(.nodes[]?, .floating_nodes[]?) | select(.type == "workspace" and .name != "__i3_scratch") | 
    {workspace: .name, windows: [.nodes[]?, .floating_nodes[]? | recurse(.nodes[]?, .floating_nodes[]?) | 
    select(.window_properties != null and .name != "__i3_scratch") | .window_properties.class]}] |
    map("\(.workspace): \(.windows | join(", "))") | join("\n")
')
# echo $workspaces

# workspaces=$(i3-msg -t get_workspaces | jq -r '.[].name')
# echo $workspaces

# Show the list in fzf for selection
# selected=$(echo "$workspaces" | fzf --prompt="Select a workspace: " --height=20% --border --reverse)
selected=$(echo "$workspaces" | rofi -dmenu)

# Extract the workspace name (text before the colon) if something is selected
if [ -n "$selected" ]; then
  workspace=$(echo "$selected" | cut -d':' -f1)
  i3-msg workspace "$workspace"
else
  echo "No workspace selected"
fi
