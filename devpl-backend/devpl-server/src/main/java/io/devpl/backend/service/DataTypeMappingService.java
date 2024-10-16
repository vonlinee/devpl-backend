package io.devpl.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import io.devpl.backend.domain.param.DataTypeListParam;
import io.devpl.backend.domain.vo.SelectOptionVO;
import io.devpl.backend.entity.DataTypeItem;
import io.devpl.backend.entity.DataTypeMapping;
import io.devpl.backend.entity.DataTypeMappingGroup;

import java.util.List;

/**
 * 类型映射 Service
 */
public interface DataTypeMappingService extends IService<DataTypeMapping> {

    /**
     * 查询所有类型映射规则分组
     *
     * @return 类型映射规则分组
     */
    List<SelectOptionVO> listMappingGroupOptions();

    /**
     * 按组 ID 查询列表
     *
     * @param groupId 组 ID
     * @return {@link List}<{@link DataTypeMapping}>
     */
    List<DataTypeMapping> listByGroupId(Long groupId);

    /**
     * 查询可添加类型映射的主类型
     *
     * @param param 类型列表查询参数
     * @return 类型信息列表
     */
    PageInfo<DataTypeItem> listSelectablePrimaryTypes(DataTypeListParam param);

    /**
     * 查询可被某个类型映射的其他类型
     *
     * @param param 类型列表查询参数
     * @return 类型信息列表
     */
    PageInfo<DataTypeItem> listSelectableAnotherTypes(DataTypeListParam param);

    /**
     * 新增类型映射分组
     *
     * @param group 分组
     * @return boolean
     */
    boolean addTypeMappingGroup(DataTypeMappingGroup group);
}
