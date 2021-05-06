package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.VisitActionEntity;
import com.stabbers.geofood.repository.VisitActionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VisitActionService {

    @Autowired
    private VisitActionRepository visitActionRepository;

    public VisitActionEntity saveVisitAction(VisitActionEntity newVisitAction) {
        return visitActionRepository.save(newVisitAction);
    }
}
