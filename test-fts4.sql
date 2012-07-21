.load fts4-rank.sqlext

-- This example (and all others in this section) assumes the following schema
CREATE VIRTUAL TABLE documents USING fts4(title, content);

INSERT INTO mail VALUES('hello world', 'This message is a hello world message.');
INSERT INTO mail VALUES('urgent: serious', 'This mail is seen as a more serious mail');

SELECT title FROM documents WHERE documents MATCH 'effect* known';

SELECT title FROM documents JOIN ( 
    SELECT docid, rank(matchinfo(documents)) AS rank 
    FROM documents
    WHERE documents MATCH 'effect* known once'
    ORDER BY rank DESC 
    LIMIT 10 OFFSET 0
) AS ranktable USING(docid)
ORDER BY ranktable.rank DESC;
