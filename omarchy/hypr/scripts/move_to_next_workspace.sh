# Workspaces
final=$(hyprctl workspaces -j | jq -r '.[-1].id')
current=$(hyprctl activeworkspace -j | jq -r '.id')
numWindowsInCurrent=$(hyprctl activeworkspace -j | jq -r '.windows')

# Find next workspace
# Should be the next workspace unless we're looking at a lone window in the last workspace, then it should wrap back to workspace 1
# We should also never create a workspace beyond 9
isCurrentWindowAloneInWorkspace=0
[ "$numWindowsInCurrent" -eq 1 ] && isCurrentWindowAloneInWorkspace=1

if [ "$isCurrentWindowAloneInWorkspace" -eq 1 ] && [ "$current" -eq "$final" ] || [ "$current" -eq 9 ]; then
  next=1
else
  next=$((current + 1))
fi

# Move current window
hyprctl dispatch movetoworkspace "$next"
