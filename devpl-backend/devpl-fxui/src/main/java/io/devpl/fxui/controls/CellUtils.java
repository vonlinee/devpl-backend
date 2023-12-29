package io.devpl.fxui.controls;

import javafx.scene.Node;
import javafx.scene.control.Cell;
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.util.StringConverter;

public class CellUtils {

    static <T> void startEdit(final Cell<T> cell, final StringConverter<T> converter, final HBox hbox, final Node graphic, final TextField textField) {
        if (textField != null) {
            textField.setText(getItemText(cell, converter));
        }
        cell.setText(null);

        if (graphic != null) {
            hbox.getChildren().setAll(graphic, textField);
            cell.setGraphic(hbox);
        } else {
            cell.setGraphic(textField);
        }
    }

    static <T> void cancelEdit(Cell<T> cell, final StringConverter<T> converter, Node graphic) {
        cell.setText(getItemText(cell, converter));
        cell.setGraphic(graphic);
    }

    /**
     * 获取单元格的文本
     *
     * @param cell      单元格
     * @param converter 转换
     * @param <T>       单元格数据类型
     * @return 单元格的文本文本
     */
    private static <T> String getItemText(Cell<T> cell, StringConverter<T> converter) {
        return converter == null ? cell.getItem() == null ? "" : cell.getItem().toString() : converter.toString(cell.getItem());
    }

    static <T> void updateItem(final Cell<T> cell, final StringConverter<T> converter, final HBox hbox, final Node graphic, final TextField textField) {
        if (cell.isEmpty()) {
            cell.setText(null);
            cell.setGraphic(null);
        } else {
            if (cell.isEditing()) {
                if (textField != null) {
                    textField.setText(getItemText(cell, converter));
                }
                cell.setText(null);
                if (graphic != null) {
                    hbox.getChildren().setAll(graphic, textField);
                    cell.setGraphic(hbox);
                } else {
                    cell.setGraphic(textField);
                }
            } else {
                cell.setText(getItemText(cell, converter));
                cell.setGraphic(graphic);
            }
        }
    }
}