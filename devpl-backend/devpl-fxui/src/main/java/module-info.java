module devpl.fxui {
    requires javafx.graphics;
    requires javafx.controls;
    requires javafx.fxml;
    requires org.jetbrains.annotations;
    requires devpl.sdk.internal;
    requires devpl.codegen;
    requires java.naming;
    requires java.management;

    exports io.devpl.fxui.controller.template;
    exports io.devpl.fxui to javafx.graphics, javafx.fxml;

    /* 开放反射权限 */
    opens io.devpl.fxui;
    opens io.devpl.fxui.app;
    opens io.devpl.fxui.controller;
    opens io.devpl.fxui.controller.mbg;
    opens io.devpl.fxui.controller.domain;
    opens io.devpl.fxui.controller.fields;
    opens io.devpl.fxui.controller.dbconn;
    opens io.devpl.fxui.view;

    exports io.devpl.fxui.model;
    opens io.devpl.fxui.model;

    requires com.jfoenix;
    requires org.slf4j;
    requires com.dlsc.formsfx;
    requires lombok;
    requires org.mybatis.generator;
    requires org.fxmisc.richtext;
    requires pagehelper;
    requires org.fxmisc.flowless;
    requires java.sql;
    requires jsch;
    requires javafx.swing;
    requires com.baomidou.mybatis.plus.annotation;
    requires javafx.web;
    requires jdk.jsobject;
    requires com.google.googlejavaformat;
    requires ognl;
    requires org.mybatis;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.ikonli.core;
    requires org.kordamp.ikonli.materialdesign2;
    requires commons.dbutils;
    requires com.google.common;
    requires org.apache.commons.lang3;
    requires org.yaml.snakeyaml;
    requires com.google.gson;
    requires easypoi.base;
    requires poi;
    requires poi.ooxml.schemas;
    requires spring.jdbc;
    requires easypoi.annotation;
    requires poi.ooxml;
    requires com.baomidou.mybatis.plus.core;
    requires com.baomidou.mybatis.plus.extension;
    requires druid;
    requires mysql.connector.j;
    requires com.squareup.javapoet;
    requires java.compiler;
    requires jsonfive.java;
    requires ST4;
    requires dom4j;
    requires xmlbeans;
    requires velocity.engine.core;
}
