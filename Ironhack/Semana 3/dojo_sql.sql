-- Challenge 1
SELECT authors.au_id, authors.au_lname, authors.au_fname, titleauthor.title_id
INTO TEMP TABLE titleid
FROM authors
JOIN titleauthor
ON authors.au_id = titleauthor.au_id;

SELECT * FROM titleid;

SELECT titleid.au_id, titleid.au_lname, titleid.au_fname, titleid.title_id, titles.title, titles.pub_id
INTO TEMP TABLE titleid2
FROM titleid 
JOIN titles
ON titleid.title_id = titles.title_id;

SELECT * FROM titleid2;

SELECT titleid2.au_id, titleid2.au_lname, titleid2.au_fname, titleid2.title, publishers.pub_name
INTO TEMP TABLE titleid3
FROM titleid2 
JOIN publishers
ON titleid2.pub_id = publishers.pub_id;

SELECT * FROM titleid3;

--Challenge 2
SELECT au_id, au_lname, au_fname, pub_name, COUNT(title)
FROM titleid3
GROUP BY au_id, au_lname, au_fname, pub_name
ORDER BY COUNT(title) DESC;

--Challenge 3
SELECT titleid.au_id, titleid.au_lname, titleid.au_fname,  SUM(qty) AS total
FROM titleid
JOIN sales 
ON titleid.title_id = sales.title_id
GROUP BY titleid.au_id, titleid.au_lname, titleid.au_fname
ORDER BY total DESC
LIMIT 3

--Challenge 4
SELECT authors.au_id,authors.au_lname,authors.au_fname, SUM(COALESCE(sales.qty,0)) AS total
FROM authors
LEFT JOIN titleauthor ON titleauthor.au_id=authors.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id,authors.au_lname,authors.au_fname
ORDER BY total DESC;



