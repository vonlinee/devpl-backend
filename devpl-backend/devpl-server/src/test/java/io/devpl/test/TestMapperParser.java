package io.devpl.test;

import io.devpl.backend.entity.MappedStatementParamMappingItem;
import io.devpl.backend.service.impl.MyBatisServiceImpl;
import io.devpl.backend.tools.mybatis.ParamMappingVisitor;
import io.devpl.codegen.parser.JavaParserUtils;
import io.devpl.sdk.io.FileUtils;
import jakarta.annotation.Resource;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Path;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@SpringBootTest
public class TestMapperParser {

    @Resource
    MyBatisServiceImpl myBatisService;

    @Test
    public void test1() {
        System.out.println(myBatisService);
    }

    @Test
    public void test2() throws ParserConfigurationException, SAXException, IOException {
        String xml = """
            <mapper>
              <select id="selectList">
                  select * from user
                  <where>
                      <if test="">
                        AND es.end_time <![CDATA[>]]> NOW()
                      </if>
                  </where>
              </select>
            </mapper>
            """;

        SAXParserFactory factory = SAXParserFactory.newInstance();
        // javax.xml.parsers.SAXParser 原生api获取parse
        SAXParser saxParser = factory.newSAXParser();
        // 获取xmlReader
        XMLReader xmlReader = saxParser.getXMLReader();

        xmlReader.setContentHandler(new DefaultHandler() {

            @Override
            public void characters(char[] ch, int start, int length) throws SAXException {
                System.out.println("=============");
                System.out.println(ch);
                System.out.println("start = " + start + " length = " + length);
                System.out.println("=============");
            }

            @Override
            public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
                System.out.println("开始 " + qName);
            }

            @Override
            public void endElement(String uri, String localName, String qName) throws SAXException {
                // System.out.println("endElement");
            }
        });

        xmlReader.parse(new InputSource(new StringReader(xml)));
    }

    @Test
    public void test3() throws IOException {
        String path = TestMapper.class.getName().replace(".", "/");

        String absolutePath = new File("").getAbsolutePath();

        Path fpath = Path.of(absolutePath, "src/test/java", path);
        ParamMappingVisitor paramMappingVisitor = new ParamMappingVisitor();

        List<MappedStatementParamMappingItem> list = FileUtils.listPaths(fpath.getParent(), pathStream -> {
            return pathStream.filter(p -> p.toString().contains("Mapper.java"))
                .map(Path::toFile).map(f -> {
                    paramMappingVisitor.setMapperFile(f);
                    return JavaParserUtils.parse(f, 17, paramMappingVisitor).orElse(Collections.emptyList());
                })
                .flatMap(Collection::stream)
                .toList();
        });

        System.out.println(list);
    }
}
