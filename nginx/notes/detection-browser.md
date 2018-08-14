# Redirection en fonction du type de browser

        
    if ($http_user_agent ~ "MSIE (6.*|7.*|8.*|9.*|10.*)" ) {
        rewrite ^(.*)$  /ie.html;
        break;
    }
    