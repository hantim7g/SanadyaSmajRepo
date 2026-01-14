package com.hst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hst.entity.MemberRule;
import com.hst.repository.MemberRuleRepository;

@Service
public class MemberRuleService {

    @Autowired
    private MemberRuleRepository repository;

    // USER view
    public List<MemberRule> getActiveRules() {
        return repository.findByActiveTrue();
    }

    // ADMIN view
    public List<MemberRule> getAllRules() {
        return repository.findAll();
    }

    public MemberRule save(MemberRule rule) {
        return repository.save(rule);
    }

    public MemberRule findById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void toggleStatus(Long id) {
        MemberRule rule = findById(id);
        rule.setActive(!rule.getActive());
        repository.save(rule);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
