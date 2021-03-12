<?php 

namespace App\DataPersister;

use ApiPlatform\Core\DataPersister\ContextAwareDataPersisterInterface;
use App\Entity\Pokemon;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\RequestStack;

class PokemonDataPersister implements ContextAwareDataPersisterInterface
{
    private $entityManager;

    private $request;

    public function __construct(EntityManagerInterface $_entityManager, RequestStack $_request) 
    {
        $this->entityManager = $_entityManager;
        $this->request = $_request->getCurrentRequest();
    }


    public function supports($data, array $context = []): bool
    {
        return $data instanceof Pokemon;
    }

    /**
     * {@inheritdoc}
     */
    public function persist($data, array $context = [])
    {
        if($this->request->getMethod() === 'POST') {
            $this->entityManager->persist($data); // note l'élément comme à ajouter et le met dans la liste d'attente
            $this->entityManager->flush();
        }
        else if($this->request->getMethod() === 'PUT') {
            $data->setDateUpdate(new \DateTime());
            $this->entityManager->persist($data); // note l'élément comme à mettre à jour et le met dans la liste d'attente
            $this->entityManager->flush();
        }
    }

    /**
     * {@inheritdoc}
     */
    public function remove($data, array $context = [])
    {
        $this->entityManager->remove($data); // noter l'élement comme "à supprimer" et le met dans les opérations en attente
        $this->entityManager->flush(); // "appliquer toutes les opération en attente"
    }
}