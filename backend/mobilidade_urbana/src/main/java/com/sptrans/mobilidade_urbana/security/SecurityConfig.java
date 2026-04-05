package com.sptrans.mobilidade_urbana.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

//Revisar depois, não tive tempo de estudar essa parte.
@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // desativa CSRF para testar APIs
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll() // permite todas as requisições
            );

        return http.build();
    }
}
