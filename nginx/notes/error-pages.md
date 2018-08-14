# Stratégie pour pages d'erreurs

## Configuration


    error_page 503 @error_503;
    location @error_503 {
        rewrite ^(.*)$ /error-503.html break;
    }

    error_page 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 420 422 423 424 426 428 429 431 444 449 450 451 500 501 502 504 505 506 507 508 509 510 511 @error_generic;
    location  @error_generic {
        rewrite ^(.*)$ /error-generic.html break;
    }

    location /error-assets {
        alias /srv/error-pages/;
    }
  
    
## Page de maintenance
    
     location / {
    
            if (-f /srv/error-pages/maintenance_on.html) {
                return 503;
            }
    
            proxy_pass   http://{{ nginx_frontend_server }};
            proxy_intercept_errors on;
        }    