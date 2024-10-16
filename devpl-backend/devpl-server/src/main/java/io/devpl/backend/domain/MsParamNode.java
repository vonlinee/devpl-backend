package io.devpl.backend.domain;

import io.devpl.backend.domain.enums.MSParamDataType;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * MyBatis Mapper Statement参数节点
 * <p>
 * antd和element-plus的树形表数据结构不同
 */
@Setter
@Getter
public class MsParamNode {

    /**
     * 这里的ID无意义，只是作为一个唯一的序号
     * 前端树形表格组件使用
     * vxe-table使用id字段，react使用key字段
     */
    private Integer key;

    /**
     * 这里的ID无意义，只是作为一个唯一的序号
     * 前端树形表格组件使用
     */
    private Integer id;

    /**
     * 父节点ID
     * 前端树形表格组件使用
     */
    private Integer parentId;

    /**
     * 父节点ID
     * 前端树形表格组件使用
     */
    private Integer parentKey;

    /**
     * 参数名
     */
    private String fieldKey;

    /**
     * 参数值
     */
    private Object value;

    /**
     * 参数值 (字面值形式)
     */
    private String literalValue;

    /**
     * 参数类型，枚举值
     */
    private String dataType = MSParamDataType.STRING.getQualifier();

    /**
     * 是否叶子结点
     */
    private Boolean leaf;

    /**
     * 子节点
     */
    private List<MsParamNode> children;

    private MSParamDataType valueType;

    public void setDataType(String dataType) {
        this.dataType = dataType;
        this.valueType = MSParamDataType.valueOfTypeName(dataType);
    }

    public boolean isLeaf() {
        return leaf == null || leaf;
    }

    public void setId(Integer id) {
        this.id = id;
        this.key = id;
    }
}
