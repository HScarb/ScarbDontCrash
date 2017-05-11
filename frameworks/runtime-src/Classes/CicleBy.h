#pragma once

#include "cocos2d.h"

class CircleBy : public cocos2d::ActionInterval
{
public:
	// 时间 圆心 一共需要旋转的角度
	static CircleBy* create(float tm, cocos2d::Vec2 circleCenter, float sumDegree);
	bool init(float tm, cocos2d::Vec2 circleCenter, float sumDegree);
	virtual void update(float dt);
	virtual void startWithTarget(cocos2d::Node *target);
	virtual CircleBy* reverse() const;
	virtual CircleBy* clone() const;

private:
	// 圆心
	cocos2d::Vec2 _circleCenter;
	cocos2d::Vec2 _originCenter;
	// 半径
	float _radius;
	// 一共需要转过的弧度
	float _sumDegree;
	// 每帧需要转过的弧度数
	float _degree;
	// 起始弧度数
	float _beginDegree;
	// 刷新次数
	int _times;
};