<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Locale"%>

<%!
    // ============================================================
    // INTERFACE AFFICHABLE - EXERCICE 3
    // ============================================================
    interface Affichable {
        String afficher();
    }

    // ============================================================
    // CLASSE ABSTRAITE ANIMAL
    // ============================================================
    abstract class Animal {
        protected String nom;

        public Animal(String nom) {
            this.nom = nom;
        }

        public abstract String crier();

        @Override
        public String toString() {
            return "Animal nommé " + nom;
        }
    }

    // ============================================================
    // CLASSE CHIEN - EXERCICES 1 ET 3
    // ============================================================
    class Chien extends Animal implements Affichable {

        public Chien(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Wouf wouf !";
        }

        @Override
        public String toString() {
            return "Chien nommé " + nom;
        }

        @Override
        public String afficher() {
            return "Affichage Chien → " + toString();
        }
    }

    // ============================================================
    // CLASSE CHAT - EXERCICES 1 ET 3
    // ============================================================
    class Chat extends Animal implements Affichable {

        public Chat(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Miaou !";
        }

        @Override
        public String toString() {
            return "Chat nommé " + nom;
        }

        @Override
        public String afficher() {
            return "Affichage Chat → " + toString();
        }
    }

    // ============================================================
    // CLASSE OISEAU - EXERCICE 4
    // ============================================================
    class Oiseau extends Animal {

        public Oiseau(String nom) {
            super(nom);
        }

        @Override
        public String crier() {
            return nom + " dit : Cui cui !";
        }

        @Override
        public String toString() {
            return "Oiseau nommé " + nom;
        }
    }

    // ============================================================
    // CLASSE ABSTRAITE FORME - EXERCICE 2
    // ============================================================
    abstract class Forme {
        public abstract double aire();
    }

    class Cercle extends Forme {
        private double rayon;

        public Cercle(double rayon) {
            this.rayon = rayon;
        }

        @Override
        public double aire() {
            return Math.PI * rayon * rayon;
        }

        @Override
        public String toString() {
            return "Cercle (rayon=" + rayon + ")";
        }
    }

    class Carre extends Forme {
        private double cote;

        public Carre(double cote) {
            this.cote = cote;
        }

        @Override
        public double aire() {
            return cote * cote;
        }

        @Override
        public String toString() {
            return "Carré (côté=" + cote + ")";
        }
    }
%>

<html>
<head>
    <title>Le polymorphisme</title>
</head>

<body bgcolor="white">

<h1>Exercices sur le polymorphisme</h1>

<form action="#" method="post">
    <p>
        <label for="nomChien">Saisir le nom d'un chien : </label>
        <input type="text" id="nomChien" name="nomChien" required>
    </p>

    <p>
        <label for="nomChat">Saisir le nom d'un chat : </label>
        <input type="text" id="nomChat" name="nomChat" required>
    </p>

    <p>
        <input type="submit" value="Faire crier les animaux">
    </p>
</form>

<%
    String nomChien = request.getParameter("nomChien");
    String nomChat = request.getParameter("nomChat");

    if (nomChien != null && nomChat != null
            && !nomChien.trim().isEmpty()
            && !nomChat.trim().isEmpty()) {

        nomChien = nomChien.trim();
        nomChat = nomChat.trim();

        Chien chien = new Chien(nomChien);
        Chat chat = new Chat(nomChat);
        Oiseau oiseau = new Oiseau("Titi");

        Animal[] animaux = { chien, chat, oiseau };
%>

<hr>

<h2>Démonstration du polymorphisme</h2>

<p>
    Le tableau est déclaré <code>Animal[]</code>, mais chaque objet utilise
    sa propre méthode <code>crier()</code>.
</p>

<%
    for (Animal animal : animaux) {
%>
        <p><%= animal.crier() %></p>
<%
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 1 : toString()
     ============================================================ -->
<h2>Exercice 1 : Redéfinir toString()</h2>

<%
    for (Animal animal : animaux) {
%>
        <p><%= animal.toString() %></p>
<%
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 2 : CLASSE ABSTRAITE FORME
     ============================================================ -->
<h2>Exercice 2 : La classe abstraite Forme</h2>

<%
    Forme[] formes = {
        new Cercle(5),
        new Carre(4)
    };

    for (Forme forme : formes) {
%>
        <p>
            <%= forme.toString() %> →
            Aire : <%= String.format(Locale.FRANCE, "%.2f", forme.aire()) %>
        </p>
<%
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 3 : INTERFACE AFFICHABLE
     ============================================================ -->
<h2>Exercice 3 : L'interface Affichable</h2>

<%
    Affichable[] affichables = { chien, chat };

    for (Affichable affichable : affichables) {
%>
        <p><%= affichable.afficher() %></p>
<%
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 4 : AJOUTER UN OISEAU
     ============================================================ -->
<h2>Exercice 4 : Ajouter un Oiseau</h2>

<p>
    L'oiseau « Titi » a été ajouté au tableau <code>Animal[]</code>.
    La boucle d'affichage reste identique : le polymorphisme permet
    d'appeler automatiquement la bonne méthode <code>crier()</code>.
</p>

<%
    for (Animal animal : animaux) {
%>
        <p><%= animal.crier() %></p>
<%
    }
%>

<hr>

<!-- ============================================================
     EXERCICE 5 : INSTANCEOF
     ============================================================ -->
<h2>Exercice 5 : L'opérateur instanceof</h2>

<%
    for (Animal animal : animaux) {
        String typeAnimal;

        if (animal instanceof Chien) {
            typeAnimal = "C'est un chien";
        } else if (animal instanceof Chat) {
            typeAnimal = "C'est un chat";
        } else {
            typeAnimal = "Autre animal";
        }
%>
        <p><%= animal.toString() %> → <%= typeAnimal %></p>
<%
    }
%>

<%
    }
%>

<p><a href="index.html">Retour au sommaire</a></p>

</body>
</html>
