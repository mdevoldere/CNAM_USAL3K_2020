<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20210312150843 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE player (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name VARCHAR(50) NOT NULL, email VARCHAR(255) DEFAULT NULL)');
        $this->addSql('CREATE TABLE pokemon (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, number VARCHAR(3) NOT NULL, name VARCHAR(255) NOT NULL, date_add DATETIME NOT NULL, date_update DATETIME DEFAULT NULL)');
        $this->addSql('CREATE TABLE pokemon_types (pokemon_id INTEGER NOT NULL, types_id INTEGER NOT NULL, PRIMARY KEY(pokemon_id, types_id))');
        $this->addSql('CREATE INDEX IDX_B6D930642FE71C3E ON pokemon_types (pokemon_id)');
        $this->addSql('CREATE INDEX IDX_B6D930648EB23357 ON pokemon_types (types_id)');
        $this->addSql('CREATE TABLE types (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name VARCHAR(255) NOT NULL, desription VARCHAR(255) NOT NULL)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE player');
        $this->addSql('DROP TABLE pokemon');
        $this->addSql('DROP TABLE pokemon_types');
        $this->addSql('DROP TABLE types');
    }
}
