<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


class CnamController extends AbstractController
{
    /**
     * @Route("/cnam", name="cnam") 
     */
    public function index(): Response
    {

        return $this->json([
            'message' => 'Welcome to your new controller!',
            'path' => 'src/Controller/CnamController.php',
        ]);
    }

    /**
     * @Route("/cnam/lister", name="toto")
     */
    public function lister(): Response
    {

        return $this->json([
            'message' => 'TOTO to your new controller!',
            'path' => 'src/Controller/CnamController.php',
        ]);
    }
}
