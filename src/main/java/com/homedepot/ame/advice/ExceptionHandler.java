package com.homedepot.ame.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.zalando.problem.spring.webflux.advice.ProblemHandling;
import org.zalando.problem.spring.webflux.advice.security.SecurityAdviceTrait;

@ControllerAdvice
public class ExceptionHandler implements ProblemHandling {
}
