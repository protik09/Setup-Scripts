# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
function chocoupdate {
    cup all -y
}
New-Alias updateall chocoupdate