<?php
include 'includes/header.php';

$search_query = isset($_GET['q']) ? trim($_GET['q']) : '';
$page_title = "Search Results - Movie Showcase";

$results = [];

if ($search_query) {
    // Search in movies
    $movie_query = "SELECT *, 'movie' as result_type FROM movies 
                   WHERE title LIKE :search 
                   LIMIT 20";
    $movie_stmt = $db->prepare($movie_query);
    $search_param = "%{$search_query}%";
    $movie_stmt->bindParam(':search', $search_param);
    $movie_stmt->execute();
    $movies = $movie_stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Search in artists
    $artist_query = "SELECT *, 'artist' as result_type FROM artists 
                    WHERE name LIKE :search 
                    LIMIT 10";
    $artist_stmt = $db->prepare($artist_query);
    $artist_stmt->bindParam(':search', $search_param);
    $artist_stmt->execute();
    $artists = $artist_stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $results = array_merge($movies, $artists);
}
?>

<div class="container">
    <h2 style="text-align: center;">Search Results for "<?php echo htmlspecialchars($search_query); ?>"</h2>
    <p style="text-align: center;">Found <?php echo count($results); ?> results</p>
</div>

<?php if (!empty($results)): ?>
    <section class="movie-frames">
        <?php foreach($results as $result): ?>
            <?php if ($result['result_type'] == 'movie'): ?>
                <div class="movie-frame">
                    <a href="<?php echo htmlspecialchars($result['tmdb_url']); ?>" target="_blank">
                        <img src="<?php echo htmlspecialchars($result['poster_url']); ?>" 
                             alt="<?php echo htmlspecialchars($result['title']); ?>">
                        <h3 style="font-size: 14px; margin-top: 10px;">
                            <?php echo htmlspecialchars($result['title']); ?>
                        </h3>
                        <p style="font-size: 12px; color: #666;">Movie</p>
                    </a>
                </div>
            <?php else: ?>
                <div class="movie-frame">
                    <a href="artist.php?id=<?php echo $result['id']; ?>">
                        <img src="<?php echo htmlspecialchars($result['profile_image']); ?>" 
                             alt="<?php echo htmlspecialchars($result['name']); ?>"
                             style="border-radius: 50%; object-fit: cover;">
                        <h3 style="font-size: 14px; margin-top: 10px;">
                            <?php echo htmlspecialchars($result['name']); ?>
                        </h3>
                        <p style="font-size: 12px; color: #666;">Artist</p>
                    </a>
                </div>
            <?php endif; ?>
        <?php endforeach; ?>
    </section>
<?php else: ?>
    <div class="container">
        <p style="text-align: center;">
            <?php if ($search_query): ?>
                No results found. Try a different search term.
            <?php else: ?>
                Please enter a search term.
            <?php endif; ?>
        </p>
    </div>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>