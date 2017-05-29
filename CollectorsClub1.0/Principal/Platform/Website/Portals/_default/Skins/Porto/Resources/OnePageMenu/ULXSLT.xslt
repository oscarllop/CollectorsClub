<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/*">
    <xsl:apply-templates select="root" />
  </xsl:template>
  <xsl:template match="root">
    <nav class="nav-main mega-menu">
      <ul class="nav nav-pills nav-main" id="mainMenu">
        <xsl:apply-templates select="node" />
      </ul>
    </nav>
  </xsl:template>
  <xsl:template match="node">
    <li>
      <xsl:attribute name="class">
        <xsl:if test="@id = 1">
          <xsl:text>dropdown-full-color dropdown-primary</xsl:text>
        </xsl:if>
        <xsl:if test="@id = 2">
          <xsl:text>dropdown-full-color dropdown-secondary</xsl:text>
        </xsl:if>
        <xsl:if test="@id = 3">
          <xsl:text>dropdown-full-color dropdown-tertiary</xsl:text>
        </xsl:if>
        <xsl:if test="@id = 4">
          <xsl:text>dropdown-full-color dropdown-quaternary</xsl:text>
        </xsl:if>
        <xsl:if test="@id = 5">
          <xsl:text>dropdown-full-color dropdown-dark</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <a>
        <xsl:attribute name="data-hash">
        </xsl:attribute>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="translate(@text, ' ', '')" />
        </xsl:attribute>
        <xsl:value-of select="@text" />
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>
