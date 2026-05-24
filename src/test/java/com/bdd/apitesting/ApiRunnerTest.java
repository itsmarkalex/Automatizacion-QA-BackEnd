package com.bdd.apitesting;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;
import static org.junit.Assert.*;

public class ApiRunnerTest {

    @Test
    public void testAll() {
        Results results = Runner.path("classpath:api")
                .outputCucumberJson(true)
                .parallel(1);
        assertEquals(results.getErrorMessages(), 0, results.getFailCount());
    }
}