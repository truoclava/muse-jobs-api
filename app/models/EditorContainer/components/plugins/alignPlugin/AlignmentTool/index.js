/* eslint-disable react/no-array-index-key */
import React from 'react';
import { Button, Icon } from 'semantic-ui-react'

import s from './index.css'

const buttons = [
  {
    icon: 'align justify',
    alignment: 'fullscreen'
  },
  {
    icon: 'align center',
    alignment: 'center'
  },
  {
    icon: 'align right',
    alignment: 'right'
  }
]

const getRelativeParent = (element) => {
  if (!element) {
    return null
  }

  const position = window
    .getComputedStyle(element)
    .getPropertyValue('position')
  if (position !== 'static') {
    return element
  }

  return getRelativeParent(element.parentElement)
}

export default class AlignmentTool extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      position: {},
      alignment: 'center',
    }

    this.onAlignmentChange = this.onAlignmentChange.bind(this)
    this.onVisibilityChanged = this.onVisibilityChanged.bind(this)
  }

  componentWillMount() {
    this.props.store.subscribeToItem('visibleBlock', this.onVisibilityChanged)
    this.props.store.subscribeToItem('alignment', this.onAlignmentChange)
  }

  componentWillUnmount() {
    this.props.store.unsubscribeFromItem(
      'visibleBlock',
      this.onVisibilityChanged,
    )
    this.props.store.unsubscribeFromItem('alignment', this.onAlignmentChange)
  }

  onVisibilityChanged(visibleBlock) {
    setTimeout(() => {
      let position
      const boundingRect = this.props.store.getItem('boundingRect')
      if (visibleBlock) {
        const relativeParent = getRelativeParent(this.toolbar.parentElement)
        const toolbarHeight = this.toolbar.clientHeight
        const relativeRect = relativeParent ? relativeParent.getBoundingClientRect() : document.body.getBoundingClientRect()
        position = {
          top: (boundingRect.top - relativeRect.top) - toolbarHeight,
          left: (boundingRect.left - relativeRect.left) + (boundingRect.width / 2),
          transform: 'translate(-50%) scale(1)',
          transition: 'transform 0.15s cubic-bezier(.3,1.2,.2,1)',
        }
      } else {
        position = { transform: 'translate(-50%) scale(0)' }
      }
      const alignment = this.props.store.getItem('alignment') || 'center'
      this.setState({
        alignment,
        position,
      })
    }, 0)
  }

  onAlignmentChange(alignment) {
    this.setState({ alignment })
  }

  render() {
    return (
      <div
        className={ s.AlignmentTool }
        style={ this.state.position }
        ref={ (toolbar) => {
          this.toolbar = toolbar
        } }
      >
        <Button.Group>
          {buttons.map((button, index) => {
            const active = button.alignment === this.state.alignment
            const setAlignment = this.props.store.getItem('setAlignment')
            return (
              <Button
                icon
                key={ index }
                className={ s.Button }
                active={ active }
                onClick={ () => setAlignment({ alignment: button.alignment }) }
              >
                <Icon name={ button.icon } />
              </Button>
            )
          })}
        </Button.Group>
      </div>
    )
  }
}
