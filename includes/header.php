<?php
require_once 'config/database.php';

$database = new Database();
$db = $database->getConnection();

// Get all artists for dropdown
$artist_query = "SELECT * FROM artists ORDER BY name";
$artist_stmt = $db->prepare($artist_query);
$artist_stmt->execute();
$artists = $artist_stmt->fetchAll(PDO::FETCH_ASSOC);

// Get all genres for dropdown
$genre_query = "SELECT * FROM genres ORDER BY name";
$genre_stmt = $db->prepare($genre_query);
$genre_stmt->execute();
$genres = $genre_stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($page_title) ? $page_title : 'Movie Showcase'; ?></title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="icon" href="assets/images/fav.png" type="image/x-icon">
</head>
<body>
    <header>
        <h1>My Favorite Movie Showcase</h1>
        <nav>
            <ul class="nav-links">
                <li><a href="index.php">Home</a></li>
                
                <!-- Dynamic Genres Dropdown -->
                <li class="dropdown">
                    <a href="javascript:void(0)" class="dropbtn">Genres</a>
                    <div class="dropdown-content">
                        <?php foreach($genres as $genre): ?>
                            <a href="genre.php?slug=<?php echo $genre['slug']; ?>">
                                <?php echo htmlspecialchars($genre['name']); ?>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </li>
                
                <!-- Dynamic Artists Dropdown -->
                <li class="dropdown">
                    <a href="javascript:void(0)" class="dropbtn">Artists</a>
                    <div class="dropdown-content artist-dropdown">
                        <?php foreach($artists as $artist): ?>
                            <a href="artist.php?id=<?php echo $artist['id']; ?>">
                                <?php echo htmlspecialchars($artist['name']); ?>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </li>
                
                <!-- Search -->
                <li>
                    <form action="search.php" method="GET" style="display: inline;">
                        <input type="text" name="q" placeholder="Search..." class="search-input" required>
                    </form>
                </li>
            </ul>
        </nav>
    </header>