<?php 

require 'vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;


$id = intval($_GET['id'] ?? 0);


if($id > 0) {
    echo 'Identifiant valide: ' . $id;
}
else {
    echo 'Identifiant invalide: ' . $id;

    $logger = new Logger('cnam');
    $stream = new StreamHandler(__DIR__ .'/cnam.log', Logger::DEBUG);

    $logger->pushHandler($stream);

    $logger->info('un identifiant invalide a été transmis');
    $logger->warning('un identifiant invalide a été transmis');
    $logger->error('un identifiant invalide a été transmis');

}


