<?php
function sanitize_input($input, $method = 'encode') {
    if ($method === 'encode') {
        return htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
    }
    if ($method === 'strip') {
        return preg_replace('/<script.*?>.*?<\/script>/is', '', $input);
    }
    return htmlspecialchars($input, ENT_QUOTES, 'UTF-8');
}

function detect_xss($input) {
    $patterns = [
        '/<\s*script/i',
        '/javascript\s*:/i',
        '/on\w+\s*=/i',
        '/<\s*iframe/i'
    ];

    foreach ($patterns as $pattern) {
        if (preg_match($pattern, $input)) {
            return true;
        }
    }
    return false;
}
?>
<!DOCTYPE html>
<html>
<head>
 <title>Secure Comment System</title>
</head>
<body>
 <h1>User Comments (Secure)</h1>

 <form method="POST">
  <label>Username:</label><br>
  <input type="text" name="username" required><br><br>

  <label>Comment:</label><br>
  <textarea name="comment" rows="4" required></textarea><br><br>

  <label>Sanitization Method:</label>
  <select name="method">
   <option value="encode">HTML Encode</option>
   <option value="strip">Strip Tags</option>
  </select><br><br>

  <button type="submit">Submit</button>
 </form>

 <?php
 if ($_POST) {
  $username = $_POST['username'] ?? '';
  $comment = $_POST['comment'] ?? '';
  $method = $_POST['method'] ?? 'encode';

  $xss_detected = detect_xss($username) || detect_xss($comment);

  $safe_username = sanitize_input($username, $method);
  $safe_comment = sanitize_input($comment, $method);

  if ($xss_detected) {
    echo "<p style='color:orange;'>Warning: Malicious content detected and sanitized.</p>";
  }

  echo "<h3>Your Comment:</h3>";
  echo "<strong>User:</strong> " . $safe_username . "<br>";
  echo "<strong>Comment:</strong> " . $safe_comment;
 }
 ?>
</body>
</html>
