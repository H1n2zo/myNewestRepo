<?php
include 'includes/header.php';

$genre_slug = isset($_GET['slug']) ? $_GET['slug'] : '';

// Get genre details
$genre_query = "SELECT * FROM genres WHERE slug = :slug";
$genre_stmt = $db->prepare($genre_query);
$genre_stmt->bindParam(':slug', $genre_slug);
$genre_stmt->execute();
$genre = $genre_stmt->fetch(PDO::FETCH_ASSOC);

if (!$genre) {
    header('Location: index.php');
    exit;
}

$page_title = htmlspecialchars($genre['name']) . " - Movie Showcase";

// Get movies in this genre
$movies_query = "SELECT m.* FROM movies m
                INNER JOIN movie_genres mg ON m.id = mg.movie_id
                WHERE mg.genre_id = :genre_id
                ORDER BY m.release_date DESC";
$movies_stmt = $db->prepare($movies_query);
$movies_stmt->bindParam(':genre_id', $genre['id']);
$movies_stmt->execute();
$movies = $movies_stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<h2 style="text-align: center;"><?php echo htmlspecialchars($genre['name']); ?></h2>

<section class="movie-frames">
    <?php if (!empty($movies)): ?>
        <?php foreach($movies as $movie): ?>
            <div class="movie-frame">
                <a href="<?php echo htmlspecialchars($movie['tmdb_url']); ?>" target="_blank">
                    <img src="<?php echo htmlspecialchars($movie['poster_url']); ?>" 
                         alt="<?php echo htmlspecialchars($movie['title']); ?>">
                    <h3 style="font-size: 14px; margin-top: 10px;">
                        <?php echo htmlspecialchars($movie['title']); ?>
                    </h3>
                </a>
            </div>
        <?php endforeach; ?>
    <?php else: ?>
        <p style="text-align: center;">No movies found in this genre.</p>
    <?php endif; ?>
</section>

<?php include 'includes/footer.php'; ?>