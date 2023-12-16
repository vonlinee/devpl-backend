package io.devpl.backend.tools.parser.java;

import com.github.javaparser.ast.CompilationUnit;

public interface CompilationUnitVisitor<T> {

    T visit(CompilationUnit cu);
}