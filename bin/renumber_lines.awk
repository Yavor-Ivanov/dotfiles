BEGIN {
    if (! new_start) {
        new_start = 1
    }
    counter = new_start
}

{
    if ($0 ~ /^[0-9]+\./) {
        old_number = substr($0, 1, index($0, ".") - 1)
        new_number = counter
        $0 = new_number "." substr($0, index($0, ".") + 1)
        counter++
    }
    print $0
}
