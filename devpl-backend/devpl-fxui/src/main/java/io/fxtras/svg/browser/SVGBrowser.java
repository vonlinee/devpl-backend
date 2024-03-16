package io.fxtras.svg.browser;

import io.fxtras.svg.SVGImage;
import io.fxtras.svg.SVGLoader;
import javafx.application.Application;
import javafx.geometry.Bounds;
import javafx.geometry.Point2D;
import javafx.geometry.Pos;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * A sample browser.
 *
 * @version 1.0
 */
public class SVGBrowser extends Application {
    private Stage stage = null;
    private final MenuBar menuBar = new MenuBar();
    private final TabPane tabPane = new TabPane();
    private final Map<Integer, SVGImage> imagesByIndex = new HashMap<>();

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage stage) {
        this.stage = stage;
        stage.setTitle("SVG Browser");
        stage.setOnHidden(t -> {
            stage.close();
            System.exit(0);
        });

        Menu fileMenu = new Menu("File");
        menuBar.getMenus().add(fileMenu);

        MenuItem openItem = new MenuItem("Open");
        fileMenu.getItems().add(openItem);
        MenuItem saveItem = new MenuItem("Save Image");
        fileMenu.getItems().add(saveItem);
        saveItem.setOnAction(t -> save());

        MenuItem exitItem = new MenuItem("Exit");
        fileMenu.getItems().add(exitItem);
        exitItem.setOnAction(t -> {
            stage.close();
            System.exit(0);
        });

        openItem.setOnAction(t -> open());

        ToolBar toolBar = new ToolBar();
        URL url = this.getClass().getResource("zoomIn.png");
        Image img = new Image(url.toString());
        Button zoomIn = new Button("", new ImageView(img));
        toolBar.getItems().add(zoomIn);

        zoomIn.setOnAction(t -> zoomIn());

        url = this.getClass().getResource("zoomOut.png");
        img = new Image(url.toString());
        Button zoomOut = new Button("", new ImageView(img));
        toolBar.getItems().add(zoomOut);

        zoomOut.setOnAction(t -> zoomOut());

        VBox vBox = new VBox();
        vBox.getChildren().add(menuBar);
        vBox.getChildren().add(toolBar);
        vBox.getChildren().add(tabPane);

        stage.setScene(new Scene(vBox, 600, 600));
        stage.show();
    }

    private void zoomIn() {
        SVGImage image = getSelectedImage();
        if (image != null) {
            // image.scale(1.2d);
            image.setScaleX(1.2d);
            image.setScaleY(1.2d);
        }
    }

    private void zoomOut() {
        SVGImage image = getSelectedImage();
        if (image != null) {
            // image.scale(0.8d);
            image.setScaleX(0.8d);
            image.setScaleY(0.8d);
        }
    }

    private Node outerNode(Node node) {
        return centeredNode(node);
    }

    private Node centeredNode(Node node) {
        VBox vBox = new VBox(node);
        vBox.setAlignment(Pos.CENTER);
        return vBox;
    }

    public boolean isEmpty() {
        return tabPane.getTabs().isEmpty();
    }

    public SVGImage getSelectedImage() {
        if (isEmpty()) {
            return null;
        }
        int index = tabPane.getSelectionModel().getSelectedIndex();
        return imagesByIndex.getOrDefault(index, null);
    }

    private void save() {
        SVGImage svgImage = getSelectedImage();
        if (svgImage == null) {
            return;
        }
        FileChooser fileChooser = new FileChooser();
        fileChooser.getExtensionFilters().addAll(new ExtensionFilter("PNG Files", "*.png"),
            new ExtensionFilter("JPEG Files", "*.jpg", ".jpeg"));
        fileChooser.setInitialDirectory(new File(System.getProperty("user.dir")));
        fileChooser.setTitle("Save as Image");
        File file = fileChooser.showSaveDialog(stage);
        if (file == null) {
            return;
        }
        String name = file.getName();
        int index = name.lastIndexOf('.');
        String ext = null;
        if (index < name.length() - 1) {
            ext = name.substring(index + 1);
        }
        if (ext != null && !ext.equals("png") && !ext.equals("jpg") && !ext.equals("jpeg")) {
            name = name + ".png";
            ext = "png";
            file = new File(file.getParentFile(), name);
        } else {
            ExtensionFilter filter = fileChooser.getSelectedExtensionFilter();
            if (filter == null) {
                name = name + ".png";
                ext = "png";
                file = new File(file.getParentFile(), name);
            }
        }
        if (ext == null) {
            ext = "png";
        } else if (ext.equals("jpeg")) {
            ext = "jpg";
        }
        svgImage.snapshot(ext, file);
    }

    private void open() {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setInitialDirectory(new File(System.getProperty("user.dir")));
        fileChooser.setTitle("Open SVG File");
        File file = fileChooser.showOpenDialog(stage);
        if (file == null) {
            return;
        }
        try {
            SVGImage image = SVGLoader.load(file.toURI().toURL());
            if (image == null) {
                Alert alert = new Alert(AlertType.WARNING);
                alert.setTitle("Error");
                alert.setHeaderText("Invalid SVG file");
                alert.setContentText("The file appear not to be a valid SVG file");
                alert.showAndWait();
                return;
            }

            Group group = new Group(image);
            MyStackPane content = new MyStackPane(group);
            group.layoutBoundsProperty().addListener((observable, oldBounds, newBounds) -> {
                // keep it at least as large as the content
                content.setMinWidth(newBounds.getWidth());
                content.setMinHeight(newBounds.getHeight());
            });
            ScrollPane scrollPane = new ScrollPane(content);
            scrollPane.setPannable(true);
            scrollPane.setFitToHeight(true);
            scrollPane.setFitToWidth(true);
            scrollPane.setPrefSize(500, 500);
            Tab tab = new Tab(file.getName(), scrollPane);
            content.allowLayoutChildren(false);
            content.setOnScroll(event -> {
                double zoomFactor = 1.05;
                double deltaY = event.getDeltaY();
                if (deltaY < 0) {
                    zoomFactor = 1 / zoomFactor;
                }
                int index = tabPane.getSelectionModel().getSelectedIndex();
                if (imagesByIndex.containsKey(index)) {
                    // https://stackoverflow.com/questions/38604780/javafx-zoom-scroll-in-scrollpane
                    Node node = imagesByIndex.get(index);
                    Bounds groupBounds = node.getBoundsInLocal();
                    final Bounds viewportBounds = scrollPane.getViewportBounds();

                    double valX = scrollPane.getHvalue() * (groupBounds.getWidth() - viewportBounds.getWidth());
                    double valY = scrollPane.getVvalue() * (groupBounds.getHeight() - viewportBounds.getHeight());

                    // scale
                    node.setScaleX(node.getScaleX() * zoomFactor);
                    node.setScaleY(node.getScaleY() * zoomFactor);

                    Point2D posInZoomTarget = node.parentToLocal(new Point2D(event.getX(), event.getY()));
                    Point2D adjustment = node.getLocalToParentTransform()
                        .deltaTransform(posInZoomTarget.multiply(zoomFactor - 1));
                    scrollPane.layout();
                    scrollPane.setViewportBounds(groupBounds);

                    groupBounds = group.getBoundsInLocal();
                    scrollPane.setHvalue((valX + adjustment.getX()) / (groupBounds.getWidth() - viewportBounds.getWidth()));
                    scrollPane.setVvalue((valY + adjustment.getY()) / (groupBounds.getHeight() - viewportBounds.getHeight()));
                }
            });
            tabPane.getTabs().add(tab);
            int tabIndex = tabPane.getTabs().size() - 1;
            imagesByIndex.put(tabIndex, image);
            tab.setOnClosed(event -> imagesByIndex.remove(tabIndex));
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private static class MyStackPane extends StackPane {
        private boolean allowLayoutChildren = true;

        private MyStackPane(Node root) {
            super(root);
        }

        private void allowLayoutChildren(boolean allow) {
            this.allowLayoutChildren = allow;
        }

        @Override
        public void layoutChildren() {
            if (allowLayoutChildren) {
                super.layoutChildren();
            }
        }
    }
}
