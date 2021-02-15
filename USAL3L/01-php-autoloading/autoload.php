<?php 

function autoload($classname) // Models\Product - Auth\User
{
    $classname = str_replace('\\', DIRECTORY_SEPARATOR, $classname);

    echo "Chargement de la classe $classname \n";


    $path = $classname.'.php';

    if(is_file($path)) {
        require $path;
    }
}

spl_autoload_register('autoload');