# Workspaces
final=$(hyprctl workspaces -j | jq -r '.[-1].id')
current=$(hyprctl activeworkspace -j | jq -r '.id')

# Find "previous" workspace
# In case we need to wrap, add one new workspace but never beyond 9
wrapTarget=$((final + 1))
[ "$wrapTarget" -gt 9 ] && wrapTarget=9

if [ "$current" -eq 1 ]; then
  previous=$wrapTarget
else
  previous=$((current - 1))
fi

# Move current window
hyprctl dispatch movetoworkspace "$previous"
