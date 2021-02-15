<?php 

require 'autoload.php';

use Models\Product;


$p1 = new Product('Mon produit', 9.99); 
$p2 = new Product('Mon produit 2 ', 19.99); 

echo $p1->getInfo();


