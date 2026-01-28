<?php
$page_title = "Home - Movie Showcase";
include 'includes/header.php';

// Get profile information
$profile_query = "SELECT * FROM profile LIMIT 1";
$profile_stmt = $db->prepare($profile_query);
$profile_stmt->execute();
$profile = $profile_stmt->fetch(PDO::FETCH_ASSOC);

// TMDB API - Get trending movies
$tmdb_api_key = "YOUR_TMDB_API_KEY_HERE"; // Get from https://www.themoviedb.org/settings/api
$trending_url = "https://api.themoviedb.org/3/trending/all/week?api_key={$tmdb_api_key}";

$trending_data = @file_get_contents($trending_url);
$trending_movies = [];

if ($trending_data) {
    $trending_json = json_decode($trending_data, true);
    if (isset($trending_json['results'])) {
        $trending_movies = array_slice($trending_json['results'], 0, 12);
    }
}

// Fallback to database
if (empty($trending_movies)) {
    $featured_query = "SELECT m.* FROM movies m 
                      INNER JOIN featured_movies fm ON m.id = fm.movie_id 
                      WHERE fm.is_active = 1 
                      ORDER BY fm.display_order 
                      LIMIT 12";
    $featured_stmt = $db->prepare($featured_query);
    $featured_stmt->execute();
    $db_movies = $featured_stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>

<div class="container">
    <div class="profile">
        <img src="<?php echo htmlspecialchars($profile['profile_image']); ?>" alt="Profile Picture">
        <h1><?php echo htmlspecialchars($profile['name']); ?></h1>
        <p><?php echo htmlspecialchars($profile['role']); ?> | <?php echo $profile['age']; ?> | <?php echo htmlspecialchars($profile['education']); ?></p>
        <p class="introduction-message" style="color: #090707;">
            <?php echo htmlspecialchars($profile['bio']); ?>
        </p>
    </div>
</div>

<h2 style="text-align: center;">Trending Movies & TV Shows</h2>

<section class="movie-frames">
    <?php if (!empty($trending_movies)): ?>
        <?php foreach($trending_movies as $movie): ?>
            <?php
            $title = isset($movie['title']) ? $movie['title'] : $movie['name'];
            $poster = "https://image.tmdb.org/t/p/w500" . $movie['poster_path'];
            $movie_id = $movie['id'];
            $media_type = $movie['media_type'];
            $tmdb_link = "https://www.themoviedb.org/{$media_type}/{$movie_id}";
            $rating = isset($movie['vote_average']) ? round($movie['vote_average'], 1) : 'N/A';
            ?>
            <div class="movie-frame">
                <a href="<?php echo $tmdb_link; ?>" target="_blank">
                    <img src="<?php echo $poster; ?>" alt="<?php echo htmlspecialchars($title); ?>">
                    <h3 style="font-size: 14px; margin-top: 10px;">
                        <?php echo htmlspecialchars($title); ?>
                    </h3>
                    <p style="font-size: 12px; color: #666;">⭐ <?php echo $rating; ?>/10</p>
                </a>
            </div>
        <?php endforeach; ?>
    <?php else: ?>
        <?php if (!empty($db_movies)): ?>
            <?php foreach($db_movies as $movie): ?>
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
            <p style="text-align: center; width: 100%;">No movies available.</p>
        <?php endif; ?>
    <?php endif; ?>
</section>

<?php include 'includes/footer.php'; ?>