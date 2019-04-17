import React, { Component } from 'react'
import { Button, Icon, Modal, Header, Form, Divider } from 'semantic-ui-react'
import { each } from 'lodash'
import ResourceDropdown from '../../../common/ResourceDropdown'

// https://images.unsplash.com/photo-1504259804616-eda856c0149a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=d865cad2743955d669ac850593138155&auto=format&fit=crop&w=1024&q=80
const initialState = {
  url: '',
  modalOpen: false,
  values: {
    photo: null,
    author: '',
    author_link: ''
  }
}

const createFormBody = (values) => {
  const body = new FormData()

  each(values, (value, key) => body.append(key, value))

  return body
}

export default class AddImage extends Component {
  constructor(props) {
    super(props)

    this.state = initialState

    this.openModal = this.openModal.bind(this)
    this.closeModal = this.closeModal.bind(this)
    this.onChange = this.onChange.bind(this)
    this.addImage = this.addImage.bind(this)
  }

  addImage() {
    const { values } = this.state
    if (this.props.banner) {
      values.banner = true
    }

    const {
      addNewImage
    } = this.props
    const body = createFormBody(values)

    addNewImage(body)

    this.setState(initialState)
  }

  onChange(evt) {
    this.setState({ url: evt.target.value })
  }

  openModal() {
    this.setState({ modalOpen: true })
  }

  closeModal() {
    this.setState({ modalOpen: false })
  }

  onValueChange = (name, value) => this.setState(({ values }) => {
    const newValues = { ...values, [name]: value }
    const valid = this.validate(newValues)

    return { values: newValues, valid }
  })

  validate = (values) => !!values.photo
  updateBanner = (e) => this.onValueChange('banner_type', e.value)

  changeAuthor = (e) => this.onValueChange('author', e.currentTarget.value)
  changeAuthorLink = (e) => this.onValueChange('author_link', e.currentTarget.value)
  changeCaption = (e) => this.onValueChange('caption', e.currentTarget.value)

  onPhotoChange = (e) => {
    const { files } = e.currentTarget
    const file = files[0]

    this.onValueChange('photo', file)
  }

  render() {
    const { modalOpen } = this.state
    const { values: { author, author_link, caption }, valid } = this.state

    let bannerDropdown

    if (this.props.banner) {
      bannerDropdown = (
        <div>
          <label>Banner</label>
          <ResourceDropdown
            resourceVal={ this.state.banner_type }
            resourceUrl="/adminapi/articles/banner_types"
            resourceKey="banner_type"
            placeholder="Select banner type"
            handleChange={ this.updateBanner }
          />
        </div>
      )
    }

    return (
      <Modal open={ modalOpen }
        size="tiny"
        trigger={
          <Button icon onClick={ this.openModal } disabled={ this.props.disabled }>
            <Icon name="image" />
          </Button>
          }
      >
        <Modal.Content>
          <Modal.Description>
            <Header>Add Image</Header>
            <Form>
              <Form.Field>
                <label>File</label>
                <input
                  type="file"
                  onChange={ this.onPhotoChange }
                />
              </Form.Field>
              {bannerDropdown}
              <Form.Field>
                <label>Author</label>
                <input type="text" value={ author } onChange={ this.changeAuthor } />
              </Form.Field>
              <Form.Field>
                <label>Link to source</label>
                <input type="text" value={ author_link } onChange={ this.changeAuthorLink } />
              </Form.Field>
              { !this.props.banner && (
                <Form.Field>
                  <label>Caption</label>
                  <textarea value={ caption } onChange={ this.changeCaption } />
                </Form.Field>
              )}
            </Form>
          </Modal.Description>
        </Modal.Content>
        <Modal.Actions>
          <Button onClick={ this.closeModal } primary>
            Cancel
          </Button>
          <Button primary onClick={ this.addImage }>
            Add Image
          </Button>
        </Modal.Actions>
      </Modal>
    )
  }
}
