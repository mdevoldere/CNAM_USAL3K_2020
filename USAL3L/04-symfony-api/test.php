<?php 

$pass = htmlspecialchars($_POST['pass']);

$pass = password_hash('azerty', PASSWORD_BCRYPT);

$test = htmlspecialchars('azerty');

if(password_verify($test, $pass)) {

}