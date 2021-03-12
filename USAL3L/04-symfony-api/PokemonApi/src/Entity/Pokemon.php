<?php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use App\Repository\PokemonRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

/**
 * @ApiResource(
 *  collectionOperations={"get", "post"},
 *  itemOperations={"get", "put", "delete"},
 *  normalizationContext={"groups": {"read"}},
 *  denormalizationContext={"groups": {"write"}}
 * )
 * @ORM\Entity(repositoryClass=PokemonRepository::class)
 */
class Pokemon
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     * @Groups("read")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=3)
     * @Groups("read", "write")
     */
    private $number;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("read", "write")
     */
    private $name;

    /**
     * @ORM\ManyToMany(targetEntity=Types::class)
     * @Groups("read", "write")
     */
    private $types;

    /**
     * @ORM\Column(type="datetime")
     * @Groups("read")
     */
    private $dateAdd;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     * @Groups("read")
     */
    private $dateUpdate;

    public function __construct()
    {
        $this->types = new ArrayCollection();

        $this->dateAdd = new \DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNumber(): ?string
    {
        return $this->number;
    }

    public function setNumber(?string $number): self
    {
        $this->number = $number;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    /**
     * @return Collection|Types[]
     */
    public function getTypes(): Collection
    {
        return $this->types;
    }

    public function addType(Types $type): self
    {
        if (!$this->types->contains($type)) {
            $this->types[] = $type;
        }

        return $this;
    }

    public function removeType(Types $type): self
    {
        $this->types->removeElement($type);

        return $this;
    }

    public function getDateAdd(): ?\DateTimeInterface
    {
        return $this->dateAdd;
    }

    public function setDateAdd(\DateTimeInterface $dateAdd): self
    {
        $this->dateAdd = $dateAdd;

        return $this;
    }

    public function getDateUpdate(): ?\DateTimeInterface
    {
        return $this->dateUpdate;
    }

    public function setDateUpdate(?\DateTimeInterface $dateUpdate): self
    {
        $this->dateUpdate = $dateUpdate;

        return $this;
    }
}
