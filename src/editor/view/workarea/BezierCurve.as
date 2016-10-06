package editor.view.workarea
{

import flash.display.Graphics;
import flash.geom.Point;

/**
 * ...
 * @author Juan Pablo Califano <califa010@gmail.com>
 */
public class BezierCurve
{

	private var _controlPoints:Array;

	/**
	 *
	 * @param    controlPoints    The definition of the Bezier curve.
	 *                            The first point is the beginning of the curve and the last one is the ending.
	 */
	public function BezierCurve(controlPoints:Array)
	{
		_controlPoints = controlPoints;
	}

	/**
	 * Mainly for debug purposes...
	 * It draws all the lines between the control points and also the interpolated points of
	 * these lines
	 */
	public function drawCurveEnvelope(graphics:Graphics, position:Number):void
	{
		var points:Array = _controlPoints;
		var colors:Array = [0x999999, 0x0000ff, 0x00ff00, 0xff00ff];
		var colIdx:int = 0;

		while (points.length > 1)
		{
			var len:int = points.length;
			var i:int = 0;
			var p1:Point;
			var p2:Point;
			var interpolated:Point;

			graphics.lineStyle(2, colors[colIdx++ % colors.length]);

			while (i < len - 1)
			{
				p1 = points[i];
				p2 = points[i + 1];
				interpolated = Point.interpolate(p2, p1, position);
				graphics.moveTo(p1.x, p1.y);
				graphics.lineTo(p2.x, p2.y);
				graphics.drawCircle(interpolated.x, interpolated.y, 2);
				graphics.endFill();
				i++;
			}
			points = getInterpolatedPoints(points, position);
		}
	}

	/**
	 * Main method. It draws a bezier curve as as defined by controlPoints at construction time.
	 * It uses lineTo to do the drawing; so in theory, a bigger the number of segments should give a
	 * more defined curve. This probably won't be too smooth in all cases, though.
	 * Perhaps there's a way to improve this.
	 *
	 * @param    graphics        the Graphic object to draw
	 * @param    numSegments        the number of lines that will be used to draw the line.
	 */
	public function draw(graphics:Graphics, numSegments:int):void
	{
		var points:Array = getCurvePoints(numSegments);

		graphics.moveTo(points[0].x, points[0].y);

		var p:Point;
		var len:int = points.length;

		for (var i:int = 0; i < len; i++)
		{
			p = points[i];
			graphics.lineTo(p.x, p.y);
		}
	}

	/**
	 * Calculates the points that form the curve as defined by controlPoints at construction time.
	 * You could use this if you want to draw the curve yourself. Otherwise, use draw()
	 *
	 * @param    numSegments        the number of lines that will be used to draw the line.
	 * @return    the list of points that can be used to draw the line.
	 */
	public function getCurvePoints(numSegments:int):Array
	{

		var points:Array = _controlPoints;

		var pos:Number = 0;
		var p:Point;
		var result:Array = [];
		for (var i:int = 0; i <= numSegments; i++)
		{
			pos = i / numSegments;
			//	p = getPointAtPosition(pos);
			p = getPointAtCurve(pos);
			result.push(p);
		}

		return result;
	}

	/**
	 * Polynomial method (less stable but probably faster according to wikipedia)
	 * Ref:
	 * http://en.wikipedia.org/wiki/B%C3%A9zier_curve
	 * "Generalization"
	 *
	 * @param    position
	 * @return
	 */
	private function getPointAtCurve(position:Number):Point
	{
		var t:Number = position;
		var n:int = _controlPoints.length - 1;

		var coeff:Array = getBinomialCoefficients(n);

		var point:Point = new Point();
		var constantMultiplier:Number;

		constantMultiplier = Math.pow(1 - t, n);
		point.x = constantMultiplier * _controlPoints[0].x;
		point.y = constantMultiplier * _controlPoints[0].y;

		for (var i:int = 1; i < n; i++)
		{
			constantMultiplier = coeff[i] * Math.pow(t, i) * Math.pow(1 - t, n - i);
			point.x += constantMultiplier * _controlPoints[i].x;
			point.y += constantMultiplier * _controlPoints[i].y;
		}

		constantMultiplier = Math.pow(t, n);
		point.x += constantMultiplier * _controlPoints[n].x;
		point.y += constantMultiplier * _controlPoints[n].y;

		return point;

	}

	private var _binomialCoefficients:Array = [];

	/**
	 * Ref:
	 * http://en.wikipedia.org/wiki/Pascal's_triangle
	 * "Calculating an individual row or diagonal by itself"
	 * @param    row
	 * @return
	 */
	private function getBinomialCoefficients(row:int):Array
	{
		if (_binomialCoefficients[row])
		{
			return _binomialCoefficients[row];
		}

		var coeff:Array = [1];

		var r:int = row;
		var c:int = 1;

		var prev:int = 1;
		var cur:int = 0;
		while (r > 0)
		{
			cur = prev * r / c;
			coeff[c] = cur;
			prev = cur;
			c++;
			r--;
		}
		_binomialCoefficients[row] = coeff;
		return coeff;
	}

	/**
	 * "Geometric" method. Stable, but probably slower (according to wikipedia)
	 *    Ref:    http://en.wikipedia.org/wiki/De_Casteljau's_algorithm
	 *            Geometric interpretation
	 *
	 * Calculates a point in the curve given a position in the range 0...1, where:
	 *        0 equals the first point in the curve (the same as the first control point)
	 *        1 equals the last point in the curve (the same as the last control point)
	 *
	 * This method contains the bulk of the algorithm used here.
	 * The idea is that you have a list of points (the control points).
	 * Each point forms a line with the next point in the list.
	 * So we have a pair of points p(i) and p(i+1) forming line l.
	 * What we have to do is find a new point along this line, for each pair.
	 * This will give us a a new list whose length is the previous list length minus 1.
	 * Now, if we repeat until we have just one point in the list, we'll have found
	 * the point we were looking for: the point along the curve, given a position [0...1]
	 *
	 * @param    position
	 * @return    the interpolated point
	 */
	public function getPointAtPosition(position:Number):Point
	{
		var points:Array = _controlPoints;
		while (points.length > 1)
		{
			points = getInterpolatedPoints(points, position);
		}
		return points[0];
	}

	/**
	 *
	 * @param    points        the list of points used to calculate the new points
	 * @param    position    how much to interpolate
	 * @return    a list        a new list of points whose length is the original list minus 1.
	 */
	private function getInterpolatedPoints(points:Array, position:Number):Array
	{
		var len:int = points.length;
		var i:int = 0;
		var p1:Point;
		var p2:Point;
		var interpolated:Point;
		var interpolatedPoints:Array = [];
		while (i < len - 1)
		{
			p1 = points[i];
			p2 = points[i + 1];
			interpolated = Point.interpolate(p2, p1, position);
			interpolatedPoints.push(interpolated);
			i++;
		}
		return interpolatedPoints;
	}

	/**
	 * Static version of draw(). Could be handy for one-liners.
	 */
	public static function drawCurve(graphics:Graphics, controlPoints:Array, numSegments:int):void
	{
		var instance:BezierCurve = new BezierCurve(controlPoints);
		instance.draw(graphics, numSegments);
	}

	/**
	 * Static version of getPointAtPosition(). Same as drawCurve(): it could be handy for one-liners.
	 */
	public static function getCurvePointAtPosition(controlPoints:Array, position:Number):Point
	{
		var instance:BezierCurve = new BezierCurve(controlPoints);
		return instance.getPointAtPosition(position);
	}
}

}
