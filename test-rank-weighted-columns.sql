.load fts4-rank.sqlext

-- This example (and all others in this section) assumes the following schema
CREATE VIRTUAL TABLE documents USING fts4(title, content);

INSERT INTO documents VALUES('hello world', 'This message is a hello world message.');
INSERT INTO documents VALUES('urgent: serious', 'This mail is seen as a more serious mail');

SELECT title FROM documents WHERE documents MATCH 'message';

-- result should be 3.0
SELECT rank(matchinfo(documents)) AS rank 
    FROM documents
    WHERE documents MATCH '"serious OR mail"'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0;

-- result should be 2.0
SELECT rank(matchinfo(documents), 2.0) AS rank 
    FROM documents
    WHERE documents MATCH '"serious OR mail"'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0;

-- result should be 1.0
SELECT rank(matchinfo(documents), 0.0, 0.5) AS rank 
    FROM documents
    WHERE documents MATCH '"serious OR mail"'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0;

-- result should be 3.8
SELECT rank(matchinfo(documents), 1.2, 1.3) AS rank 
    FROM documents
    WHERE documents MATCH '"serious OR mail"'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0;

/* should fail */
SELECT rank(matchinfo(documents), 0.0, 0.0, 1.7) AS rank 
    FROM documents
    WHERE documents MATCH '"serious OR mail"'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0;
