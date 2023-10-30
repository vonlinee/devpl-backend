package io.devpl.generator.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.devpl.generator.common.query.ListResult;
import io.devpl.generator.domain.param.Query;
import io.devpl.generator.common.mvc.BaseServiceImpl;
import io.devpl.generator.dao.FieldTypeMapper;
import io.devpl.generator.entity.GenFieldType;
import io.devpl.generator.service.FieldTypeService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 字段类型管理
 */
@Service
public class FieldTypeServiceImpl extends BaseServiceImpl<FieldTypeMapper, GenFieldType> implements FieldTypeService {

    @Override
    public ListResult<GenFieldType> page(Query query) {
        IPage<GenFieldType> page = baseMapper.selectPage(
            getPage(query),
            getWrapper(query)
        );
        return ListResult.ok(page);
    }

    @Override
    public Map<String, GenFieldType> getMap() {
        List<GenFieldType> list = baseMapper.selectList(null);
        Map<String, GenFieldType> map = new LinkedHashMap<>(list.size());
        for (GenFieldType entity : list) {
            map.put(entity.getColumnType().toLowerCase(), entity);
        }
        return map;
    }

    @Override
    public Set<String> getPackageByTableId(Long tableId) {
        Set<String> importList = baseMapper.getPackageByTableId(tableId);
        return importList.stream().filter(StringUtils::hasText).collect(Collectors.toSet());
    }

    @Override
    public Set<String> getList() {
        return baseMapper.list();
    }

    @Override
    public boolean save(GenFieldType entity) {
        entity.setCreateTime(new Date());
        return super.save(entity);
    }
}
