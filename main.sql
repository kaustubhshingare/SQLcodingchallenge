CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255)NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
);

CREATE TABLE Categories(
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100)NOT NULL 
);
CREATE TABLE Artworks (
ArtworkID INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
ArtistID INT,
CategoryID INT,
Year INT,
Description TEXT,
ImageURL VARCHAR(255),
FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

CREATE TABLE Exhibitions (
ExhibitionID INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
StartDate DATE,
EndDate DATE,
Description TEXT);

CREATE TABLE ExhibitionArtworks (
ExhibitionID INT,
ArtworkID INT,
PRIMARY KEY (ExhibitionID, ArtworkID),
FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));

INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg');

    INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

    INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);
    
 SELECT a.Name, COUNT(aw.ArtworkID) AS ArtworkCount
FROM Artists a
LEFT JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID
ORDER BY ArtworkCount DESC;

SELECT aw.Title
FROM Artworks aw
JOIN Artists a ON aw.ArtistID = a.ArtistID
WHERE a.Nationality IN ('Spanish', 'Dutch')
ORDER BY aw.Year ASC;

SELECT a.Name, COUNT(aw.ArtworkID) AS PaintingCount
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
WHERE aw.CategoryID = 1 -- Assuming 'Painting' has CategoryID 1
GROUP BY a.ArtistID;

SELECT aw.Title, a.Name AS ArtistName, c.Name AS CategoryName
FROM ExhibitionArtworks ea
JOIN Artworks aw ON ea.ArtworkID = aw.ArtworkID
JOIN Artists a ON aw.ArtistID = a.ArtistID
JOIN Categories c ON aw.CategoryID = c.CategoryID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
WHERE e.Title = 'Modern Art Masterpieces';

 SELECT a.Name
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID
HAVING COUNT(aw.ArtworkID) > 2;

 SELECT aw.Title
FROM Artworks aw
JOIN ExhibitionArtworks ea1 ON aw.ArtworkID = ea1.ArtworkID
JOIN Exhibitions e1 ON ea1.ExhibitionID = e1.ExhibitionID
JOIN ExhibitionArtworks ea2 ON aw.ArtworkID = ea2.ArtworkID
JOIN Exhibitions e2 ON ea2.ExhibitionID = e2.ExhibitionID
WHERE e1.Title = 'Modern Art Masterpieces' AND e2.Title = 'Renaissance Art';

 SELECT c.Name AS CategoryName, COUNT(aw.ArtworkID) AS ArtworkCount
FROM Categories c
LEFT JOIN Artworks aw ON c.CategoryID = aw.CategoryID
GROUP BY c.CategoryID;

 SELECT a.Name
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID
HAVING COUNT(aw.ArtworkID) > 3;

SELECT aw.Title
FROM Artworks aw
JOIN Artists a ON aw.ArtistID = a.ArtistID
WHERE a.Nationality = 'Spanish';

 SELECT e.Title
FROM Exhibitions e
JOIN ExhibitionArtworks ea ON e.ExhibitionID = ea.ExhibitionID
JOIN Artworks aw ON ea.ArtworkID = aw.ArtworkID
JOIN Artists a ON aw.ArtistID = a.ArtistID
WHERE a.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY e.ExhibitionID
HAVING COUNT(DISTINCT a.ArtistID) = 2;

 SELECT aw.Title
FROM Artworks aw
LEFT JOIN ExhibitionArtworks ea ON aw.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL;

 SELECT a.Name
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID
HAVING COUNT(DISTINCT aw.CategoryID) = (SELECT COUNT(*) FROM Categories);

SELECT c.Name AS CategoryName, COUNT(aw.ArtworkID) AS ArtworkCount
FROM Categories c
LEFT JOIN Artworks aw ON c.CategoryID = aw.CategoryID
GROUP BY c.CategoryID;

 SELECT a.Name
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID
HAVING COUNT(aw.ArtworkID) > 2;

SELECT c.Name AS CategoryName, AVG(aw.Year) AS AverageYear
FROM Categories c
JOIN Artworks aw ON c.CategoryID = aw.CategoryID
GROUP BY c.CategoryID
HAVING COUNT(aw.ArtworkID) > 1;

SELECT aw.Title
FROM Artworks aw
JOIN ExhibitionArtworks ea ON aw.ArtworkID = ea.ArtworkID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
WHERE e.Title = 'Modern Art Masterpieces';

 SELECT c.Name AS CategoryName
FROM Categories c
JOIN Artworks aw ON c.CategoryID = aw.CategoryID
GROUP BY c.CategoryID
HAVING AVG(aw.Year) > (SELECT AVG(Year) FROM Artworks);

 SELECT aw.Title
FROM Artworks aw
LEFT JOIN ExhibitionArtworks ea ON aw.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL;

 SELECT DISTINCT a.Name
FROM Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
WHERE aw.CategoryID = (SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa');

 SELECT a.Name, COUNT(aw.ArtworkID) AS ArtworkCount
FROM Artists a
LEFT JOIN Artworks aw ON a.ArtistID = aw.ArtistID
GROUP BY a.ArtistID;


 

    
