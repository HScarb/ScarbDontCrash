#pragma once

#include "cocos2d.h"

class CircleBy : public cocos2d::ActionInterval
{
public:
	// ʱ�� Բ�� һ����Ҫ��ת�ĽǶ�
	static CircleBy* create(float tm, cocos2d::Vec2 circleCenter, float sumDegree);
	bool init(float tm, cocos2d::Vec2 circleCenter, float sumDegree);
	virtual void update(float dt);
	virtual void startWithTarget(cocos2d::Node *target);
	virtual CircleBy* reverse() const;
	virtual CircleBy* clone() const;

private:
	// Բ��
	cocos2d::Vec2 _circleCenter;
	cocos2d::Vec2 _originCenter;
	// �뾶
	float _radius;
	// һ����Ҫת���Ļ���
	float _sumDegree;
	// ÿ֡��Ҫת���Ļ�����
	float _degree;
	// ��ʼ������
	float _beginDegree;
	// ˢ�´���
	int _times;
};