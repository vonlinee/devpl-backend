package io.devpl.fxui;

import io.devpl.fxui.app.MainApplication;
import io.devpl.fxui.app.MainUI;
import javafx.application.Application;

import java.io.IOException;

public class Launcher {
    public static void main(String[] args) throws IOException {
        Application.launch(MainApplication.class, args);
    }
}
