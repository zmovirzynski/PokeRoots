-- @docclass
UIImageViewBar = extends(UIWidget, "UIImageViewBar")

function UIImageViewBar.create()
  local imageView = UIImageViewBar.internalCreate()
  imageView.zoom = 1
  imageView.minZoom = math.pow(10, -2)
  imageView.maxZoom = math.pow(10,  2)
  imageView:setClipping(true)
  return imageView
end

function UIImageViewBar:getDefaultZoom()
  local width = self:getWidth()
  local height = self:getHeight()
  local textureWidth = self:getImageTextureWidth()
  local textureHeight = self:getImageTextureHeight()
  local zoomX = width / textureWidth
  local zoomY = height / textureHeight
  return math.min(zoomX, zoomY)
end

function UIImageViewBar:getImagePosition(x, y)
  x = x or self:getWidth() / 2
  y = y or self:getHeight() / 2
  local offsetX = self:getImageOffsetX()
  local offsetY = self:getImageOffsetY()
  local posX = (x - offsetX) / self.zoom
  local posY = (y - offsetY) / self.zoom
  return posX, posY
end

function UIImageViewBar:setImage(image)
  self:setImageSource(image)
  local zoom = self:getDefaultZoom()
  self:setZoom(zoom)
  self:center()
end

function UIImageViewBar:setZoom(zoom, x, y)
  zoom = math.max(math.min(zoom, self.maxZoom), self.minZoom)
  local posX, posY = self:getImagePosition(x, y)
  local textureWidth = self:getImageTextureWidth()
  local textureHeight = self:getImageTextureHeight()
  local imageWidth = textureWidth * zoom
  local imageHeight = textureHeight * zoom
  self:setImageWidth(imageWidth)
  self:setImageHeight(imageHeight)
  self.zoom = zoom
  self:move(posX, posY, x, y)
end

function UIImageViewBar:zoomIn(x, y)
  local zoom = self.zoom * 1.1
  self:setZoom(zoom, x, y)
end

function UIImageViewBar:zoomOut(x, y)
  local zoom = self.zoom / 1.1
  self:setZoom(zoom, x, y)
end

function UIImageViewBar:center()
  self:move(self:getImageTextureWidth() / 2, self:getImageTextureHeight() / 2)
end

function UIImageViewBar:move(x, y, centerX, centerY)
  x = math.max(math.min(x, self:getImageTextureWidth()), 0)
  y = math.max(math.min(y, self:getImageTextureHeight()), 0)
  local centerX = centerX or self:getWidth() / 2
  local centerY = centerY or self:getHeight() / 2
  local offsetX = centerX - x * self.zoom
  local offsetY = centerY - y * self.zoom
  self:setImageOffset({x=offsetX, y=offsetY})
end

function UIImageViewBar:onDragEnter(pos)
  return true
end

function UIImageViewBar:onDragMove(pos, moved)
  local posX, posY = self:getImagePosition()
  self:move(posX - moved.x / self.zoom, posY - moved.y / self.zoom)
  return true
end

function UIImageViewBar:onDragLeave(widget, pos)
  return true
end