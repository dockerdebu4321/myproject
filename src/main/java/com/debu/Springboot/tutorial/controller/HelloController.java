package com.debu.Springboot.tutorial.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class HelloController {

    @Value("${welcome.message}")
    private String welcomeMesssage;

    @GetMapping("/test")
    public String helloWorld() {
        return welcomeMesssage;
    }
}
