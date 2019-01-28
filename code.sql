WITH funnels AS (
SELECT distinct quiz.user_id,
home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
home_try_on.number_of_pairs, purchase.user_id IS NOT NULL AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON home_try_on.user_id = quiz.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id)
SELECT number_of_pairs, COUNT(*) AS 'num_quiz',
	SUM(is_home_try_on) AS 'is_home_try_on',
  SUM(is_purchase) AS 'is_purchase',
  1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'quiz_to_home_try_on',
  1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnels
GROUP BY number_of_pairs
ORDER BY number_of_pairs;