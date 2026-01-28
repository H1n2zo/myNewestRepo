<?php
include 'includes/header.php';

$artist_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

// Get artist details
$artist_query = "SELECT * FROM artists WHERE id = :id";
$artist_stmt = $db->prepare($artist_query);
$artist_stmt->bindParam(':id', $artist_id);
$artist_stmt->execute();
$artist = $artist_stmt->fetch(PDO::FETCH_ASSOC);

if (!$artist) {
    header('Location: index.php');
    exit;
}

$page_title = htmlspecialchars($artist['name']) . " - Movie Showcase";

// Get artist's movies
$movies_query = "SELECT m.* FROM movies m
                INNER JOIN movie_artists ma ON m.id = ma.movie_id
                WHERE ma.artist_id = :artist_id
                ORDER BY m.release_date DESC";
$movies_stmt = $db->prepare($movies_query);
$movies_stmt->bindParam(':artist_id', $artist_id);
$movies_stmt->execute();
$movies = $movies_stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="container">
    <div class="profile">
        <img src="<?php echo htmlspecialchars($artist['profile_image']); ?>" 
             alt="<?php echo htmlspecialchars($artist['name']); ?>">
        <h1><?php echo htmlspecialchars($artist['name']); ?></h1>
        <?php if ($artist['bio']): ?>
            <p><?php echo htmlspecialchars($artist['bio']); ?></p>
        <?php endif; ?>
    </div>
</div>

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
        <p style="text-align: center; width: 100%;">No movies found for this artist.</p>
    <?php endif; ?>
</section>

<?php include 'includes/footer.php'; ?>