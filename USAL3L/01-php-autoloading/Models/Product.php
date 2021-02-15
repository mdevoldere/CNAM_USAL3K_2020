<?php 
// Models\Product

namespace Models;

/**
 * Représente un produit quelconque
 */
class Product 
{
    /** @var string $name Le nom du produit */
    private string $name;

    /** @var float $price Le prix du produit */
    private float $price;

    /**
     * Construit un nouveau produit
     * @param string $_name Le nom du produit
     * @param float $_price Le prix du produit
     */
    public function __construct(string $_name, float $_price)
    {
        $this->name = $_name;
        $this->price = $_price;
    }

    /**
     * Retourne les informations du produit
     * @return string Les informations du produit sous forme de chaine de caractères
     */
    public function getInfo(): string
    {
        return $this->name . ': ' . $this->price;
    }
}