package com.hst.service;

import com.hst.entity.LoginUser;
import com.hst.repository.LoginUserRepository;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final LoginUserRepository loginUserRepository;

    public CustomUserDetailsService(LoginUserRepository loginUserRepository) {
        this.loginUserRepository = loginUserRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String mobile) throws UsernameNotFoundException {
        LoginUser user = loginUserRepository.findByMobile(mobile)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with mobile: " + mobile));

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getMobile())
                .password(user.getPassword())
                .roles(user.getRole())
                .build();
    }
}
