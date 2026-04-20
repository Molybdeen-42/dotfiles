function fish_greeting
    echo -n "Welcome back "
    set_color --bold green
    echo -n $USER
    set_color normal
    echo "!"
    echo -n "This is your friendly interactive shell, "
    set_color --bold green
    echo -n "fish"
    set_color normal
    echo "!"
end