package io.devpl.codegen.generator.config.xml;

import java.io.Serial;
import java.util.ArrayList;
import java.util.List;

public class MultiMessageException extends Exception {

    @Serial
    private static final long serialVersionUID = -5358501949588130025L;
    private final List<String> errors = new ArrayList<>();

    public MultiMessageException(List<String> errors) {
        this.errors.addAll(errors);
    }

    public MultiMessageException(String error) {
        this.errors.add(error);
    }

    public List<String> getErrors() {
        return errors;
    }

    @Override
    public String getMessage() {
        return errors.get(0);
    }
}
